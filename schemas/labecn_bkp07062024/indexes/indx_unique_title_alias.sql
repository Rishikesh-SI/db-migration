-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: indx_unique_title_alias
-- Type: INDEX

-- Name: indx_unique_title_alias; Type: INDEX; Schema: labecn_bkp07062024; Owner: -
--

CREATE UNIQUE INDEX indx_unique_title_alias ON labecn_bkp07062024.labecn_video USING btree (title_alias);


--
