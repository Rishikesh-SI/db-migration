-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_contact scom_contact_id
-- Type: CONSTRAINT

-- Name: labmcfc_contact scom_contact_id; Type: CONSTRAINT; Schema: labmcfc; Owner: -
--

ALTER TABLE ONLY labmcfc.labmcfc_contact
    ADD CONSTRAINT scom_contact_id PRIMARY KEY (contact_id);


--
