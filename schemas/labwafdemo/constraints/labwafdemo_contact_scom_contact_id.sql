-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: labwafdemo_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labwafdemo_contact scom_contact_id; Type: CONSTRAINT; Schema: labwafdemo; Owner: -
--

ALTER TABLE ONLY labwafdemo.labwafdemo_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
