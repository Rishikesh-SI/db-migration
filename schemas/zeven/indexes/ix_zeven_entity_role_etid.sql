-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_entity_role_etid
-- Type: INDEX

-- Name: ix_zeven_entity_role_etid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_entity_role_etid ON zeven.zeven_entity_role USING btree (entity_type_id);


--
