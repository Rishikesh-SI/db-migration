-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_page_alias
-- Type: INDEX

-- Name: ix_mum_page_alias; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_page_alias ON tmmimg_upd.tmmimg_upd_page USING btree (alias);


--
