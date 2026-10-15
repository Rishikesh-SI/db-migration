-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labmi.labmi_entity_role USING btree (entity_group_id);


--
