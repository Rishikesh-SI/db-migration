-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_container swa_container_id
-- Type: CONSTRAINT

-- Name: labtcs_container swa_container_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_container
    ADD CONSTRAINT swa_container_id PRIMARY KEY (container_id);


--
