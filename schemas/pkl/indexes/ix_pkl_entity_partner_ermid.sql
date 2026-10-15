-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_entity_partner_ermid
-- Type: INDEX

-- Name: ix_pkl_entity_partner_ermid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_entity_partner_ermid ON pkl.pkl_entity_partner USING btree (entity_role_map_id);


--
