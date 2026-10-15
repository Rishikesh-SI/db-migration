-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labrao; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labrao.labrao_rating_week USING btree (rating_year);


--
