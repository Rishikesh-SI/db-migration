-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_entity_role_egid
-- Type: INDEX

-- Name: ix_yho_entity_role_egid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_entity_role_egid ON yho.yho_entity_role USING btree (entity_group_id);


--
