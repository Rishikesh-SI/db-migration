-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_hero_rating_wn
-- Type: INDEX

-- Name: ix_scup_hero_rating_wn; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_hero_rating_wn ON u17wc.u17wc_hero_rating USING btree (entity_role_map_id);


--
