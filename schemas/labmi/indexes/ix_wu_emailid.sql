-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_wu_emailid
-- Type: INDEX

-- Name: ix_wu_emailid; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_wu_emailid ON labmi.labmi_web_user USING btree (upper_email_id);


--
