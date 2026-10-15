-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labisp_contact scom_contact_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
