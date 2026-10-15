-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_wu_ug
-- Type: INDEX

-- Name: ix_wu_ug; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_wu_ug ON labmi_beta_22042024.labmi_web_user USING btree (user_guid);


--
