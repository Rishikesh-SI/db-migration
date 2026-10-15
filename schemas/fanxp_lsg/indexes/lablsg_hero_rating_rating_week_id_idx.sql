-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_hero_rating_rating_week_id_idx
-- Type: INDEX

-- Name: lablsg_hero_rating_rating_week_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_hero_rating_rating_week_id_idx ON fanxp_lsg.lablsg_hero_rating USING btree (rating_week_id);


--
