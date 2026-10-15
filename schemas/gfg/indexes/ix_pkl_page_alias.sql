-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_page_alias
-- Type: INDEX

-- Name: ix_pkl_page_alias; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_page_alias ON gfg.gfg_page USING btree (alias);


--
