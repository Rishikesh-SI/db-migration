-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_entity_role_egid
-- Type: INDEX

-- Name: ix_khi_entity_role_egid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_entity_role_egid ON khi.khi_entity_role USING btree (entity_group_id);


--
