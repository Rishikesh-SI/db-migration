-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_entity_role_egid
-- Type: INDEX

-- Name: ix_zeven_entity_role_egid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_entity_role_egid ON zeven.zeven_entity_role USING btree (entity_group_id);


--
