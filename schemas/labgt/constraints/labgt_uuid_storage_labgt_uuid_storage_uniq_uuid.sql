-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_uuid_storage labgt_uuid_storage_uniq_uuid
-- Type: CONSTRAINT

-- Name: labgt_uuid_storage labgt_uuid_storage_uniq_uuid; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_uuid_storage
    ADD CONSTRAINT labgt_uuid_storage_uniq_uuid UNIQUE (uuid);


--
