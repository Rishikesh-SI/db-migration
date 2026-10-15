-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_uuid_storage labdd_v1_uuid_storage_uniq_uuid
-- Type: CONSTRAINT

-- Name: labdd_v1_uuid_storage labdd_v1_uuid_storage_uniq_uuid; Type: CONSTRAINT; Schema: labdd_v1; Owner: -
--

ALTER TABLE ONLY labdd_v1.labdd_v1_uuid_storage
    ADD CONSTRAINT labdd_v1_uuid_storage_uniq_uuid UNIQUE (uuid);


--
