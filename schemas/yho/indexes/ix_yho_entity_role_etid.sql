-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_entity_role_etid
-- Type: INDEX

-- Name: ix_yho_entity_role_etid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_entity_role_etid ON yho.yho_entity_role USING btree (entity_type_id);


--
