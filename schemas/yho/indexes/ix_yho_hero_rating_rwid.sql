-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_hero_rating_rwid
-- Type: INDEX

-- Name: ix_yho_hero_rating_rwid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_hero_rating_rwid ON yho.yho_hero_rating USING btree (rating_week_id);


--
