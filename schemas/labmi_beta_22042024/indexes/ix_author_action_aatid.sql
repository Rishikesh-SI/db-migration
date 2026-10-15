-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labmi_beta_22042024.labmi_author_action USING btree (asset_type_id, asset_id);


--
