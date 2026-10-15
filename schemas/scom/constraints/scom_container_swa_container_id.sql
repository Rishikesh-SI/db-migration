-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_container swa_container_id
-- Type: CONSTRAINT

-- Name: scom_container swa_container_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_container
    ADD CONSTRAINT swa_container_id PRIMARY KEY (container_id);


--
