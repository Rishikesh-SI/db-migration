-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labmi_beta_22042024.labmi_entity_role USING btree (entity_group_id);


--
