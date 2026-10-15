-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_rating_week_ry
-- Type: INDEX

-- Name: ix_swa_rating_week_ry; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_rating_week_ry ON swa.swa_rating_week USING btree (rating_year);


--
