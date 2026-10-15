-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_entity_role_etid
-- Type: INDEX

-- Name: ix_dd_entity_role_etid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_entity_role_etid ON dd.dd_entity_role USING btree (entity_type_id);


--
