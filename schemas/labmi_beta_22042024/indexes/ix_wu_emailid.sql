-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_wu_emailid
-- Type: INDEX

-- Name: ix_wu_emailid; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_wu_emailid ON labmi_beta_22042024.labmi_web_user USING btree (upper_email_id);


--
