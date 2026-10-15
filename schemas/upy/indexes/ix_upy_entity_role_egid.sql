-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_entity_role_egid
-- Type: INDEX

-- Name: ix_upy_entity_role_egid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_entity_role_egid ON upy.upy_entity_role USING btree (entity_group_id);


--
