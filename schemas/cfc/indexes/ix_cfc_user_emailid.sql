-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_user_emailid
-- Type: INDEX

-- Name: ix_cfc_user_emailid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_user_emailid ON cfc.cfc_user USING btree (email_id);


--
