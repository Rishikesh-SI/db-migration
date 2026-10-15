-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labtcs_contact scom_contact_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
