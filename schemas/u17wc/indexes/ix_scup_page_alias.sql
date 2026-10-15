-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_page_alias
-- Type: INDEX

-- Name: ix_scup_page_alias; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_page_alias ON u17wc.u17wc_page USING btree (alias);


--
