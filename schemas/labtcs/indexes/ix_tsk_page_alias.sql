-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_page_alias
-- Type: INDEX

-- Name: ix_tsk_page_alias; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_page_alias ON labtcs.labtcs_page USING btree (alias);


--
