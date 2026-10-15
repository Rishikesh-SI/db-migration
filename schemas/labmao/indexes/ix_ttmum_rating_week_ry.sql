-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: ix_ttmum_rating_week_ry
-- Type: INDEX

-- Name: ix_ttmum_rating_week_ry; Type: INDEX; Schema: labmao; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_ry ON labmao.labmao_rating_week USING btree (rating_year);


--
