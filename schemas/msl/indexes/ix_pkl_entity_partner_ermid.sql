-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_entity_partner_ermid
-- Type: INDEX

-- Name: ix_pkl_entity_partner_ermid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_entity_partner_ermid ON msl.msl_entity_partner USING btree (entity_role_map_id);


--
