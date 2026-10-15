-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labirao; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labirao.labirao_rating_week USING btree (rating_year);


--
