-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labgt.labgt_entity_role USING btree (entity_group_id);


--
