-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_uuid_storage labrr_uuid_storage_uniq_uuid
-- Type: CONSTRAINT

-- Name: labrr_uuid_storage labrr_uuid_storage_uniq_uuid; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_uuid_storage
    ADD CONSTRAINT labrr_uuid_storage_uniq_uuid UNIQUE (uuid);


--
