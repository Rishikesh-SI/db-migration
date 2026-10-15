-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labacko_contact scom_contact_id; Type: CONSTRAINT; Schema: labacko; Owner: -
--

ALTER TABLE ONLY labacko.labacko_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
