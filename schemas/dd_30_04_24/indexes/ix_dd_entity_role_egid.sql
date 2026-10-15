-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_entity_role_egid
-- Type: INDEX

-- Name: ix_dd_entity_role_egid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_entity_role_egid ON dd_30_04_24.dd_entity_role USING btree (entity_group_id);


--
