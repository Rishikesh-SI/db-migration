-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_hero_rating_wn
-- Type: INDEX

-- Name: ix_khi_hero_rating_wn; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_hero_rating_wn ON khi.khi_hero_rating USING btree (entity_role_map_id);


--
