-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: indx_unique_title_alias
-- Type: INDEX

-- Name: indx_unique_title_alias; Type: INDEX; Schema: labecn; Owner: -
--

CREATE UNIQUE INDEX indx_unique_title_alias ON labecn.labecn_video USING btree (title_alias);


--
