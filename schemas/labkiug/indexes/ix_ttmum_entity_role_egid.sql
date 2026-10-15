-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiug
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labkiug; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labkiug.labkiug_entity_role USING btree (entity_group_id);


--
