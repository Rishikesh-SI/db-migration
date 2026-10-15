-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_entity_role_etid
-- Type: INDEX

-- Name: ix_upy_entity_role_etid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_entity_role_etid ON upy.upy_entity_role USING btree (entity_type_id);


--
