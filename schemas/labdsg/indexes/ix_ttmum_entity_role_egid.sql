-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labdsg; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labdsg.labdsg_entity_role USING btree (entity_group_id);


--
