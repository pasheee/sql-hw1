BEGIN;


CREATE TABLE IF NOT EXISTS public."Помещение / E1"
(
    id serial,
    name character varying(32) NOT NULL,
    volume double precision NOT NULL,
    temperature double precision NOT NULL,
    humidity double precision NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."Стеллаж / E2"
(
    id serial,
    storage_id integer NOT NULL,
    client_id integer,
    "number" integer NOT NULL,
    space integer NOT NULL,
    height double precision,
    width double precision,
    length double precision,
    max_load double precision,
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
    shelf_position integer NOT NULL,
    height double precision,
    width double precision,
    length double precision,
    weight double precision,
    receive_date date,
    contract_number integer NOT NULL,
    contract_end_date date,
    temperature double precision,
    humidity double precision,
    PRIMARY KEY (id)
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