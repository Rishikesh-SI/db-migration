-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_mum_hero_rating_rwid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_hero_rating_rwid ON tmm.tmm_hero_rating USING btree (rating_week_id);


--
