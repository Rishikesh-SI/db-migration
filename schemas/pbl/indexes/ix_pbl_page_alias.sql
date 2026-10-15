-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_page_alias
-- Type: INDEX

-- Name: ix_pbl_page_alias; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_page_alias ON pbl.pbl_page USING btree (alias);


--
