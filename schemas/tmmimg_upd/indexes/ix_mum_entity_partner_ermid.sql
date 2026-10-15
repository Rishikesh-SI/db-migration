-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_entity_partner_ermid
-- Type: INDEX

-- Name: ix_mum_entity_partner_ermid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_entity_partner_ermid ON tmmimg_upd.tmmimg_upd_entity_partner USING btree (entity_role_map_id);


--
