-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: ix_labrao_web_user_guid
-- Type: INDEX

-- Name: ix_labrao_web_user_guid; Type: INDEX; Schema: labmao; Owner: -
--

CREATE UNIQUE INDEX ix_labrao_web_user_guid ON labmao.labmao_web_user USING btree (user_guid);


--
