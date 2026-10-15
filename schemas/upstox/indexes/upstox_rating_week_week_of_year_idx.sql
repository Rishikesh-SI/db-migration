-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_rating_week_week_of_year_idx
-- Type: INDEX

-- Name: upstox_rating_week_week_of_year_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_rating_week_week_of_year_idx ON upstox.upstox_rating_week USING btree (week_of_year);


--
