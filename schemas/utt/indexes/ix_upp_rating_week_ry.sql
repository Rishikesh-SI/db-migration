-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_rating_week_ry
-- Type: INDEX

-- Name: ix_upp_rating_week_ry; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_rating_week_ry ON utt.utt_rating_week USING btree (rating_year);


--
