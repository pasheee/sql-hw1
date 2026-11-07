BEGIN;


CREATE TABLE IF NOT EXISTS public."Помещение / E1"
(
    id serial,
    name character varying(32) NOT NULL,
    volume double precision NOT NULL CHECK (volume > 0),
    temperature double precision NOT NULL,
    humidity double precision NOT NULL CHECK (humidity BETWEEN 0 AND 100),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."Стеллаж / E2"
(
    id serial,
    storage_id integer NOT NULL,
    client_id integer,
    "number" integer NOT NULL CHECK ("number" > 0),
    space integer NOT NULL CHECK (space > 0),
    height double precision NOT NULL CHECK (height > 0),
    width double precision NOT NULL CHECK (width > 0),
    length double precision NOT NULL CHECK (length > 0),
    max_load double precision NOT NULL CHECK (max_load > 0),
    PRIMARY KEY (id),
    UNIQUE (id, client_id)
);

CREATE TABLE IF NOT EXISTS public."Клиент / E3"
(
    id serial,
    name character varying(256) NOT NULL,
    bank_requisites character varying NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."Товар / E4"
(
    id serial,
    client_id integer NOT NULL,
    shelf_id integer NOT NULL,
    shelf_position integer NOT NULL CHECK (shelf_position > 0),
    height double precision NOT NULL CHECK (height > 0),
    width double precision NOT NULL CHECK (width > 0),
    length double precision NOT NULL CHECK (length > 0),
    weight double precision NOT NULL CHECK (weight > 0),
    receive_date date NOT NULL,
    contract_number integer NOT NULL CHECK (contract_number > 0),
    contract_end_date date NOT NULL,
    temperature double precision NOT NULL,
    humidity double precision NOT NULL CHECK (humidity BETWEEN 0 AND 100),
    PRIMARY KEY (id),
    CHECK (contract_end_date >= receive_date)
);

ALTER TABLE IF EXISTS public."Стеллаж / E2"
    ADD FOREIGN KEY (storage_id)
    REFERENCES public."Помещение / E1" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Стеллаж / E2"
    ADD FOREIGN KEY (client_id)
    REFERENCES public."Клиент / E3" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Товар / E4"
    ADD FOREIGN KEY (client_id)
    REFERENCES public."Клиент / E3" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Товар / E4"
    ADD FOREIGN KEY (shelf_id, client_id)
    REFERENCES public."Стеллаж / E2" (id, client_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Стеллаж / E2"
    ADD UNIQUE (storage_id, "number");


ALTER TABLE IF EXISTS public."Товар / E4"
    ADD UNIQUE (shelf_id, shelf_position);

END;