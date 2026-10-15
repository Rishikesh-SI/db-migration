-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_rating_week_woty
-- Type: INDEX

-- Name: ix_pkl_rating_week_woty; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_rating_week_woty ON gfg.gfg_rating_week USING btree (week_of_year);


--
