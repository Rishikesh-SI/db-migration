-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_hero_rating_rwid
-- Type: INDEX

-- Name: ix_khi_hero_rating_rwid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_hero_rating_rwid ON khi.khi_hero_rating USING btree (rating_week_id);


--
