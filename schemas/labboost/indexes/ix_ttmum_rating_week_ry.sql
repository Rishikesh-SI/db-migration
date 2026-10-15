-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labboost.labboost_rating_week USING btree (rating_year);


--
