-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_entity_role_etid
-- Type: INDEX

-- Name: ix_khi_entity_role_etid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_entity_role_etid ON khi.khi_entity_role USING btree (entity_type_id);


--
